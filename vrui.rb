require 'formula'

class Vrui < Formula
  ver = "3.1-002"
  pkgver = "1"

  homepage 'http://keckcaves.org/software/vrui'
  url "https://github.com/KeckCAVES/Vrui.git", :revision => "v#{ver}"
  version "#{ver}-#{pkgver}"

  depends_on :x11 => '2.7.6'
  depends_on :libpng
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  # Patch for Yosemite & ElCapitan to fix the error
  # "error: cast from pointer to smaller type 'GLuint' (aka 'unsigned int') loses information"
  patch :p0, "--- GL/GLGeometryShader.cpp	2016-07-28 00:32:04.000000000 +0200
+++ /tmp/GLGeometryShader.cpp	2016-07-27 23:28:00.000000000 +0200
@@ -133,9 +133,9 @@
 	if(!geometryShaderObjects.empty())
 		{
 		/* Set the input/output parameters: */
-		glProgramParameteriEXT(GLuint(programObject),GL_GEOMETRY_INPUT_TYPE_EXT,geometryInputType);
-		glProgramParameteriEXT(GLuint(programObject),GL_GEOMETRY_OUTPUT_TYPE_EXT,geometryOutputType);
-		glProgramParameteriEXT(GLuint(programObject),GL_GEOMETRY_VERTICES_OUT_EXT,maxNumOutputVertices);
+		glProgramParameteriEXT(GLuint(reinterpret_cast<uintptr_t>(programObject)),GL_GEOMETRY_INPUT_TYPE_EXT,geometryInputType);
+		glProgramParameteriEXT(GLuint(reinterpret_cast<uintptr_t>(programObject)),GL_GEOMETRY_OUTPUT_TYPE_EXT,geometryOutputType);
+		glProgramParameteriEXT(GLuint(reinterpret_cast<uintptr_t>(programObject)),GL_GEOMETRY_VERTICES_OUT_EXT,maxNumOutputVertices);

 		/* Check for errors: */
 		GLenum err=glGetError();
"

  def install
    args = []

    args << "INSTALLDIR=#{prefix}"
    args << "DOCINSTALLDIR=#{doc}"
    args << "ETCINSTALLDIR=#{etc}/#{name}"
    args << "EXECUTABLEINSTALLDIR=#{bin}"
    args << "HEADERINSTALLDIR=#{include}/#{name}"
    args << "LIBINSTALLDIR=#{lib}/#{name}"
    args << "PKGCONFIGINSTALLDIR=#{lib}/pkgconfig"
    args << "PLUGININSTALLDIR=#{lib}/#{name}"
    args << "SHAREINSTALLDIR=#{share}/#{name}"

    args << "JPEG_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "TIFF_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "LIBUSB1_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "PNG_BASEDIR=#{(MacOS.version >= :mountain_lion) ? HOMEBREW_PREFIX : MacOS::X11.prefix}"
    args << "X11_BASEDIR=#{MacOS::X11.prefix}"
    args << "GL_BASEDIR=#{MacOS::X11.prefix}"
    args << "GLU_BASEDIR=#{MacOS::X11.prefix}"

    args << "SHOWCOMMAND=1"

    system "make", *args
    system "make", *(args+["install"])
  end
end
