/**
 * release-postinstall.js
 *
 * XXX: We want to keep this script installable at least with node 4.x.
 *
 * This script is bundled with the `npm` package and executed on release.
 * Since we have a 'fat' NPM package (with all platform binaries bundled),
 * this postinstall script extracts them and puts the current platform's
 * bits in the right place.
 */

var path = require("path");
var cp = require("child_process");
var fs = require("fs");
var os = require("os");
var platform = process.platform;

function copyRecursive(srcDir, dstDir) {
  var results = [];
  var list = fs.readdirSync(srcDir);
  var src, dst;
  list.forEach(function(file) {
    src = path.join(srcDir, file);
    dst = path.join(dstDir, file);

    var stat = fs.statSync(src);
    if (stat && stat.isDirectory()) {
      try {
        fs.mkdirSync(dst);
      } catch (e) {
        console.log("directory already exists: " + dst);
        console.error(e);
      }
      results = results.concat(copyRecursive(src, dst));
    } else {
      try {
        fs.writeFileSync(dst, fs.readFileSync(src));
      } catch (e) {
        console.log("could't copy file: " + dst);
        console.error(e);
      }
      results.push(src);
    }
  });
  return results;
}

var rootDir = path.join(__dirname, "..", "..");

var buildEnv = cp.execSync("esy build-env --json", { cwd: rootDir });
var buildEnvAsString = buildEnv.toString("utf8");
var buildEnv = JSON.parse(buildEnvAsString);

var cur__install = buildEnv["cur__install"];

console.log(cur__install);

fs.mkdirSync("_prebuilt");
copyRecursive(cur__install, path.join(rootDir, "_prebuilt"));

process.exit(0);
