/*
 Gradle script to build ExpenseReimbursementData.jar
 */
 
apply plugin: 'java'
apply plugin: 'maven'
apply plugin: 'maven-publish'

compileJava {
  sourceCompatibility = 1.6
  targetCompatibility = 1.6
  }

group = 'ExpenseReimbursementData'
description = 'ExpenseReimbursementData'

/* Nexus repositories to fetch dependencies */
repositories {
     
    maven {
        url "https://nexus.nml.com/repository/fieldrewards-maven-release/" }
    
    maven {
        url "https://nexus.nml.com/repository/fieldrewards-maven-all/" }
    
} // end of repositories

/* Defining source code folder */ 
jar {
    sourceSets {
            main {
                java {
                    srcDirs = ['JavaSource']
                    
                    from('/JavaSource/')
		                 {
                     include '**/*.xml'
                     }
                                        
                } //end of java          
            } // end of main
      } // end of sourceSets
      
      
    } // END OF JAR
    

/* Compiling dependencies */
dependencies {
      compile ( 
          [group: 'com.nm.commisns.dcmbken', name: 'commisns_dcmbken', version: '+'],
          [group: 'com.nm.commisns.dcmrpcd', name: 'commisns_dcmrpcd', version: '+'],
          [group: 'com.nm.commisns.distopr', name: 'commisns_distopr', version: '+'],
          [group: 'com.nm.commisns.common', name: 'commisns_common', version: '+'],
          [group: 'com.nm.commisns.frdataaccess', name: 'commisns_frdataaccess', version: '+'],
          [group: 'com.nm.commisns.distdwh', name: 'commisns_distdwh', version: '+'],
	        [group: 'org.springframework', name: 'spring-beans', version: '4.2.1.RELEASE'],
	        [group: 'org.springframework', name: 'spring-core', version: '4.2.1.RELEASE'],
	        [group: 'log4j', name: 'log4j', version: '1.2.12']          
   ) 
   
} //end of dependencies



publishing { 
	publications { 
		maven(MavenPublication) { 
			groupId 'com.nm.commisns.expensereimbursement'
			from components.java 
		} 
	} 
} 

model { 
	tasks.generatePomFileForMavenPublication { 
		destination = file("$buildDir/libs/pom.xml") 
	} 
} 

check.dependsOn {tasks.findAll { task -> task.name.startsWith('generatePomFileForMavenPublication') }}
