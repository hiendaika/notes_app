allprojects {
    repositories {
        google()
        mavenCentral()
    }





}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Add code from here
        afterEvaluate { project ->
            if (project.hasProperty("android")) {
                project.android {
                    if (namespace = {
                            namespace = project.group
                        }
                }
            }
        }

        afterEvaluate { project ->
            if (project.plugins.hasPlugin("com.android.application") ||
                project.plugins.hasPlugin("com.android.library")) {
                project.android {
                    compileSdkVersion(34)
                    buildToolsVersion("34.0.0")
                }
            }
        }

    // to here
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
