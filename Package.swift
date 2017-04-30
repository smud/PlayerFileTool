import PackageDescription

let package = Package(
    name: "PlayerFileTool",
    dependencies: [
        .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0),
        .Package(url: "https://github.com/smud/ConfigFile.git", majorVersion: 1),
    ]
)
