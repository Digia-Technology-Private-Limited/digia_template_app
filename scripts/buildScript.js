const Mustache = require('mustache');
const fs = require("fs");
const yaml = require("js-yaml")
const axios = require('axios');
const path = require('path');
//Hit api to get project details
//Download Icon png
//Move Icon to assets/images
const userId = process.argv[2];
const projectId = process.argv[3];

const processPreviewBuild = async (userId, projectId) => {
const sampleData = {
    appName: "",
    appDescription: "",
    packageId: "",
    themeColor: "",
    iconName: "",
    debugIconName: "",
    assetBase: `https://preview-build-assets.s3.ap-south-1.amazonaws.com/${userId}/${projectId}/`, //can modify this to cdn url
}
// call api using fetch and get project details and update the below variables
await axios.post('https://app.digia.tech/api/v1/config/getProjectDetails', {
    projectId: projectId,
}).then(async (response) => {
    if (response.data.isSuccess) {
        console.log('Project details fetched successfully')
        const projectDetails = response.data.data.response;
        console.log(JSON.stringify(projectDetails))
        // download icon
        const iconUrl = 'https://firebasestorage.googleapis.com/v0/b/digia-builder-dashboard-42470.appspot.com/o/uploads%2FgdqbnZ6xbNRmj692yMq26ji2qsH3%2F64f581f9007b81d85eceec68%2FappAssests%2Fbytesl.png?alt=media&token=35e6b8b1-81a5-402a-97d8-77acd8a3e16c&_gl=1*4r29i7*_ga*MTYyMjM2NDEzOC4xNjc2MTEyNDY5*_ga_CW55HF8NVT*MTY5NzcwMzM1Mi41Mi4xLjE2OTc3MDQwODQuNTIuMC4w';
        const urlParts = iconUrl.split('/');
        const iconNameWithToken = urlParts[urlParts.length - 1];
        const iconName = iconNameWithToken.split('?')[0];
        const outputPath = path.join(__dirname, `../assets/images/${iconName}`);
        await axios({
            method: 'get',
            url: iconUrl,
            responseType: 'stream'
        }).then(function (response) {
            response.data.pipe(fs.createWriteStream(outputPath))
            console.log('Icon downloaded successfully')
        }).catch((error) => {
            console.log(error);
        });
        sampleData.appName = projectDetails.appName;
        sampleData.appDescription = projectDetails.appDescription;
        sampleData.packageId = projectDetails.packageId;
        sampleData.themeColor = projectDetails.themeColor;
        sampleData.iconName = iconName;
        sampleData.debugIconName = iconName;
        // Update applicationId, bundleId, icon in flavorizer.yaml
        const flavorFile = yaml.load(fs.readFileSync('../flavorizr.yaml.template', "utf8"));
        flavorFile.flavors = {
            dev: {
                app: {
                    name: sampleData.appName + "-Dev",
                },
                android: {
                    applicationId: sampleData.packageId + '.dev',
                    icon: `assets/images/${sampleData.debugIconName}`
                },
                ios: {
                    bundleId: sampleData.packageId + '.dev',
                    icon: `assets/images/${sampleData.debugIconName}`
                }
            },
            production: {
                app: {
                    name: sampleData.appName,
                },
                android: {
                    applicationId: sampleData.packageId,
                    icon: `assets/images/${sampleData.iconName}`
                },
                ios: {
                    bundleId: sampleData.packageId,
                    icon: `assets/images/${sampleData.iconName}`
                }
            }
        }

        fs.writeFileSync('../flavorizr.yaml', yaml.dump(flavorFile));

        //update index.html file with variables
        const template = fs.readFileSync('../web/index.html.mustache', "utf8");
        const rendered = Mustache.render(template, sampleData);
        fs.writeFileSync('../web/index.html', rendered)

        //update web manifest
        let manifest = JSON.parse(fs.readFileSync('../web/manifest.json.template', "utf8"));
        manifest = {
            ...manifest,
            name: sampleData.appName,
            shortName: sampleData.appName,
            description: sampleData.appDescription
        }
        fs.writeFileSync('../web/manifest.json', JSON.stringify(manifest, null, 4));

        const appConfig = {
            projectId
        }
        console.log( JSON.stringify(appConfig, null, 4))
        fs.writeFileSync('../appConfig.json', JSON.stringify(appConfig, null, 4));
        //generate icons for flutter web
        const webConfig = yaml.load(fs.readFileSync('../flutter_launcher_icons_web.yaml.template', "utf8"));
        webConfig.flutter_launcher_icons.web = {
            generate: true,
            image_path: `assets/images/${sampleData.iconName}`,
            background_color: sampleData.themeColor,
            theme_color: sampleData.themeColor
        }
        fs.writeFileSync('../flutter_launcher_icons_web.yaml', yaml.dump(webConfig));
    } else {
        console.log('Error while fetching project details')
        console.log(response.data);
    }
}).catch((error) => {
    console.log(error);
});

}

processPreviewBuild(userId, projectId);