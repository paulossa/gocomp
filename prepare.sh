java -jar eclipseWorkspace/GoTranslator/lib/java-cup-11a.jar -parser Syntactic -destdir eclipseWorkspace/GoTranslator/src/go/core/< eclipseWorkspace/GoTranslator/spec/spec.cup &&
java -jar eclipseWorkspace/GoTranslator/lib/jflex-1.6.1.jar -d eclipseProject/GoTranslator/src/go/core/ --nobak eclipseWorkspace/GoTranslator/spec/rules.flex