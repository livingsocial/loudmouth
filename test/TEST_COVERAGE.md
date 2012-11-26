Loudmouth Test Coverage
=======================

Steps to check the test coverage:

1) Download JSCover from [here](http://tntim96.github.com/JSCover/)
2) Run the JSCover JAR file

    java -jar <path to JSCover>/target/dist/JSCover.jar -ws --branch --document-root=<path to Loudmouth>

3) Open http://localhost:8080/jscoverage.html?test/index.html
4) Click on the SUMMARY tab & review the results