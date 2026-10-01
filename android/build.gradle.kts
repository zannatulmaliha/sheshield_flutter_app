allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Compatibility fixes for older Flutter plugins that do not declare
// an Android namespace and/or use older Java/Kotlin defaults.
subprojects {
    afterEvaluate {
        extensions.findByType(com.android.build.gradle.BaseExtension::class.java)?.apply {
            compileOptions {
                sourceCompatibility = JavaVersion.VERSION_17
                targetCompatibility = JavaVersion.VERSION_17
            }

            // isar_flutter_libs 3.1.0+1 is outdated: it has no namespace
            // (AGP 8+ requires one) and compiles against android-30, but its
            // AndroidX dependencies need compileSdk 34+.
            if (project.name == "isar_flutter_libs") {
                if (namespace == null) {
                    namespace = "dev.isar.isar_flutter_libs"
                }
                compileSdkVersion(36)
            }
        }

        tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile::class.java).configureEach {
            compilerOptions.jvmTarget.set(
                org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
            )
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory =
        newBuildDir.dir(project.name)

    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}