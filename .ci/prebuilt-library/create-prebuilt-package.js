/**
 * create-prebuilt-package.js
 *
 * This script creates the template for a package that has prebuilt binaries.
 */

const fs = require("fs");
const path = require("path");

const rootDir = path.join(__dirname, "..", "..")

console.log("Creating package.json");
const mainPackageJson = require(path.join(rootDir, "package.json"));
const exportedEnv = mainPackageJson["esy"].exportedEnv || {};
const packageJson = JSON.stringify(
    {
        name: mainPackageJson.name + "-prebuilt",
        version: mainPackageJson.version,
        license: mainPackageJson.license,
        description: mainPackageJson.description,
        repository: mainPackageJson.repository,
        esy: {
            build: [
                "./copy-prebuilts.sh",
                "echo Copy complete."
            ],
            exportedEnv: exportedEnv,
        },
        files: [
            "copy-prebuilts.sh",
            "platform-linux/",
            "platform-darwin/",
            "platform-win32/"
        ]
    },
    null,
    2
);

fs.writeFileSync(
  path.join(rootDir, "_release", "package.json"),
  packageJson, 
  {
    encoding: "utf8"
  }
);

console.log("Copying README.md");
fs.copyFileSync(
  path.join(rootDir, "README.md"),
  path.join(rootDir, "_release", "README.md")
);

console.log("Copying copy-prebuilts.sh");
fs.copyFileSync(
  path.join(__dirname, "copy-prebuilts.sh"),
  path.join(rootDir, "_release", "copy-prebuilts.sh")
);
fs.chmodSync(path.join(rootDir, "_release", "copy-prebuilts.sh"), 0o755);
