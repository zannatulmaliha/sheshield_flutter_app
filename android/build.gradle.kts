allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Some plugins (e.g. another_telephony, used for the SOS feature's direct
// SMS send) ship a build.gradle that leaves Java/Kotlin compile targets at
// their tool defaults, which no longer agree with each other under current
// AGP/Kotlin versions ("Inconsistent JVM Target Compatibility"). Forcing
// every subproject to the same target the app itself uses (17) fixes it
// without needing to patch the plugin.
subprojects {
    afterEvaluate {
        extensions.findByType(com.android.build.gradle.BaseExtension::class.java)?.apply {
            compileOptions {
                sourceCompatibility = JavaVersion.VERSION_17
                targetCompatibility = JavaVersion.VERSION_17
            }
        }
        tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile::class.java).configureEach {
            compilerOptions.jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
