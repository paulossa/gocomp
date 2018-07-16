SET "destdir=eclipseWorkspace/GoTranslator/src/go/core/"
SET "specdir=eclipseWorkspace/GoTranslator/spec/"
java -cp %JFLEX_HOME%/lib/java-cup-11a.jar java_cup.Main -parser Syntactic -destdir %destdir% < %specdir%spec.cup
jflex -d eclipseWorkspace/GoTranslator/src/go/core/ --nobak %specdir%rules.flex
