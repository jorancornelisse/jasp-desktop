QT_DIR=~/Qt/5.5
R_FRAMEWORK=~/Jasp/Build/Frameworks/R.framework
JASP_DESKTOP=~/Jasp/Build/jasp-desktop
JASP_VERSION=0.7.5-Beta3

# This script builds the JASP.dmg installer
# Run this script from the build-jasp-desktop-Release folder 

# Remove from last time

rm -rf app
rm -rf JASP.zip
rm -f tmp.dmg
rm -f JASP*.dmg

# Create output tree

mkdir app/
mkdir app/JASP.app/
mkdir app/JASP.app/Contents/
mkdir app/JASP.app/Contents/MacOS/
mkdir app/JASPEngine.app/
mkdir app/JASPEngine.app/Contents/
mkdir app/JASPEngine.app/Contents/MacOS

# Create a symbolic link to Applications 

cd app
ln -s /Applications .
cd ..


# Copy the two executables into place

cp JASP       app/JASP.app/Contents/MacOS/
cp JASPEngine app/JASPEngine.app/Contents/MacOS/

# Create apps from each executable
# We do this to the JASPEngine, because this process
# fixes the rpaths

$QT_DIR/clang_64/bin/macdeployqt app/JASP.app/
$QT_DIR/clang_64/bin/macdeployqt app/JASPEngine.app/

# Copy the JASPEngine out of the JASPEngine.app into the JASP.app
# This will now have had it's rpaths fixed

cp app/JASPEngine.app/Contents/MacOS/JASPEngine app/JASP.app/Contents/MacOS/
rm -rf app/JASPEngine.app/

# Copy the R.framework in, the Resources, App info, icon, etc.

cp -r $R_FRAMEWORK app/JASP.app/Contents/Frameworks
cp -r $JASP_DESKTOP/Resources/* app/JASP.app/Contents/Resources
cp -r R           app/JASP.app/Contents/MacOS

cp $JASP_DESKTOP/Tools/icon.icns app/JASP.app/Contents/Resources
cp $JASP_DESKTOP/Tools/Info.plist app/JASP.app/Contents

# Create the .dmg
hdiutil create -size 800m tmp.dmg -ov -volname "JASP" -fs HFS+ -srcfolder "app"
hdiutil convert tmp.dmg -format UDZO -o JASP.dmg
mv JASP.dmg JASP-$JASP_VERSION.dmg
rm -f tmp.dmg