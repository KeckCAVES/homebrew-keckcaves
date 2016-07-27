require 'formula'

class Lidarviewer < Formula
  ver = "2.12"
  pkgver = "1"

  homepage 'http://keckcaves.org/software/lidarviewer'
  url "https://github.com/KeckCAVES/LidarViewer.git", :revision => "v#{ver}"
  version "#{ver}-#{pkgver}"

  depends_on 'KeckCAVES/keckcaves/vrui'

  # Patch for Yosemite & ElCapitan to fix the error
  # "error: cast from pointer to smaller type 'GLuint' (aka 'unsigned int') loses information"
  patch :p0, "--- PointBasedLightingShader.cpp	2016-07-28 00:13:57.000000000 +0200
+++ PointBasedLightingShader.cpp	2016-07-27 23:42:18.000000000 +0200
@@ -252,9 +252,9 @@
 		glCompileShaderFromString(geometryShader,geometryShaderSource);

 		/* Set the geometry shader's parameters: */
-		glProgramParameteriARB(programObject,GL_GEOMETRY_VERTICES_OUT_ARB,4);
-		glProgramParameteriARB(programObject,GL_GEOMETRY_INPUT_TYPE_ARB,GL_POINTS);
-		glProgramParameteriARB(programObject,GL_GEOMETRY_OUTPUT_TYPE_ARB,GL_TRIANGLE_STRIP);
+		glProgramParameteriARB(reinterpret_cast<uintptr_t>(programObject),GL_GEOMETRY_VERTICES_OUT_ARB,4);
+		glProgramParameteriARB(reinterpret_cast<uintptr_t>(programObject),GL_GEOMETRY_INPUT_TYPE_ARB,GL_POINTS);
+		glProgramParameteriARB(reinterpret_cast<uintptr_t>(programObject),GL_GEOMETRY_OUTPUT_TYPE_ARB,GL_TRIANGLE_STRIP);

 		/* Compile the surfel fragment shader: */
 		const char* fragmentShaderSource=
"

  def install
    args = []
    args << "INSTALLDIR=#{prefix}"
    args << "ETCINSTALLDIR=#{etc}/#{name}"
    args << "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/vrui/make"
    args << "JPEG_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "TIFF_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "LIBUSB1_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "PNG_BASEDIR=#{MacOS::X11.prefix}"
    args << "X11_BASEDIR=#{MacOS::X11.prefix}"
    args << "GL_BASEDIR=#{MacOS::X11.prefix}"
    args << "GLU_BASEDIR=#{MacOS::X11.prefix}"
    args << "SHOWCOMMAND=1"
    system "make", *args
    system "make", *(args+["install"])
  end
end
