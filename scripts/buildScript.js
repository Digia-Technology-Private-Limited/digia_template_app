const Mustache = require('mustache');
const fs = require("fs");
const yaml = require("js-yaml")

//Hit api to get project details
//Download Icon png
//Move Icon to assets/images

const sampleData  = {
    appName: "Bytes",
    appDescription: "An app for bytes of news",
    packageId: "com.digia.bytes",
    themeColor: "#0175C3",
    iconName: "byte.png",
    debugIconName: "byte-debug.png",
    assetBase: "/", //can modify this to cdn url
}

//Update applicationId, bundleId, icon in flavorizer.yaml
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
    description: sampleData.description
}
fs.writeFileSync('../web/manifest.json', JSON.stringify(manifest, null, 4));

//generate icons for flutter web
const webConfig = yaml.load(fs.readFileSync('../flutter_launcher_icons_web.yaml.template', "utf8"));
webConfig.flutter_launcher_icons.web = {
    generate: true,
    image_path: `assets/images/${sampleData.iconName}`,
    background_color: sampleData.themeColor,
    theme_color: sampleData.themeColor
} 
fs.writeFileSync('../flutter_launcher_icons_web.yaml', yaml.dump(webConfig));





