// Top-level build file where you can add configuration options common to all sub-projects/modules.
buildscript {
    ext.kotlin_version = "1.9.0" // Alterado para aspas duplas
    repositories {
        google()
        mavenCentral() // <-- Corrigido aqui: "mavenCentral()"
    }
    dependencies {
        // Android Gradle Plugin (AGP) - Versão 8.1.0 é compatível com Gradle 8.12
        classpath("com.android.tools.build:gradle:8.1.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral() // <-- Corrigido aqui também: "mavenCentral()"
    }
}

// As linhas a seguir foram mantidas do seu arquivo original
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
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
