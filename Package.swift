import PackageDescription

let package = Package(
    name: "PlayerFileTool",
    dependencies: [
        .Package(url: "https://github.com/smud/ConfigFile.git", majorVersion: 1),
    ]
)
