require 'formula'

class Vrui < Formula
  ver = "3.1-002"
  pkgver = "1"

  homepage 'http://keckcaves.org/software/vrui'
  url "https://github.com/KeckCAVES/Vrui.git", :revision => "v#{ver}"
  version "#{ver}-#{pkgver}"

  depends_on :x11 => '2.7.6'
  depends_on 'libpng'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  # Patch for Yosemite & ElCapitan to fix the error
  # "error: cast from pointer to smaller type 'GLuint' (aka 'unsigned int') loses information"
  patch :p0, "--- GL/GLGeometryShader.cpp	2016-10-02 00:52:52.000000000 +0200
+++ new/GL/GLGeometryShader.cpp	2016-10-02 00:53:32.000000000 +0200
@@ -133,9 +133,9 @@
 	if(!geometryShaderObjects.empty())
 		{
 		/* Set the input/output parameters: */
-		glProgramParameteriEXT(GLuint(programObject),GL_GEOMETRY_INPUT_TYPE_EXT,geometryInputType);
-		glProgramParameteriEXT(GLuint(programObject),GL_GEOMETRY_OUTPUT_TYPE_EXT,geometryOutputType);
-		glProgramParameteriEXT(GLuint(programObject),GL_GEOMETRY_VERTICES_OUT_EXT,maxNumOutputVertices);
+                glProgramParameteriEXT(GLuint(reinterpret_cast<uintptr_t>(programObject)),GL_GEOMETRY_INPUT_TYPE_EXT,geometryInputType);
+                glProgramParameteriEXT(GLuint(reinterpret_cast<uintptr_t>(programObject)),GL_GEOMETRY_OUTPUT_TYPE_EXT,geometryOutputType);
+                glProgramParameteriEXT(GLuint(reinterpret_cast<uintptr_t>(programObject)),GL_GEOMETRY_VERTICES_OUT_EXT,maxNumOutputVertices);  
 		
 		/* Check for errors: */
 		GLenum err=glGetError();
--- Images/GetImageFileSize.cpp	2017-10-17 02:39:20.000000000 +0200
+++ new/Images/GetImageFileSize.cpp	2017-10-17 02:38:30.000000000 +0200
@@ -173,7 +173,7 @@
 		jpeg_stdio_src(&jpegDecompressStruct,jpegFile.getFilePtr());
 		
 		/* Read the JPEG file header: */
-		jpeg_read_header(&jpegDecompressStruct,true);
+		jpeg_read_header(&jpegDecompressStruct,static_cast<boolean>(true));
 		
 		/* Prepare for decompression: */
 		jpeg_start_decompress(&jpegDecompressStruct);
--- Images/ReadJPEGImage.cpp	2017-10-17 02:39:20.000000000 +0200
+++ new/Images/ReadJPEGImage.cpp	2017-10-17 02:38:30.000000000 +0200
@@ -80,7 +80,7 @@
 		thisPtr->next_input_byte=static_cast<JOCTET*>(buffer);
 		
 		/* Return true if all data has been read: */
-		return bufferSize!=0;
+		return static_cast<boolean>(bufferSize!=0);
 		}
 	static void skipInputDataFunction(j_decompress_ptr cinfo,long count)
 		{
@@ -147,7 +147,7 @@
 	try
 		{
 		/* Read the JPEG file header: */
-		jpeg_read_header(&jpegDecompressStruct,true);
+		jpeg_read_header(&jpegDecompressStruct,static_cast<boolean>(true));
 		
 		/* Prepare for decompression: */
 		jpeg_start_decompress(&jpegDecompressStruct);
--- Video/ImageExtractorMJPG.cpp	2017-10-17 02:39:20.000000000 +0200
+++ new/Video/ImageExtractorMJPG.cpp	2017-10-17 02:38:30.000000000 +0200
@@ -204,7 +204,7 @@
 	jpegStruct->src=&mjr;
 	
 	/* Read the abbreviated image file header: */
-	jpeg_read_header(jpegStruct,true);
+	jpeg_read_header(jpegStruct,static_cast<boolean>(true));
 	
 	/* Set the decompressor's output color space to Y'CbCr: */
 	jpegStruct->out_color_space=JCS_YCbCr;
@@ -257,7 +257,7 @@
 	jpegStruct->src=&mjr;
 	
 	/* Read the abbreviated image file header: */
-	jpeg_read_header(jpegStruct,true);
+	jpeg_read_header(jpegStruct,static_cast<boolean>(true));
 	
 	/* Prepare the decompressor: */
 	jpeg_start_decompress(jpegStruct);
@@ -283,7 +283,7 @@
 	jpegStruct->src=&mjr;
 	
 	/* Read the abbreviated image file header: */
-	jpeg_read_header(jpegStruct,true);
+	jpeg_read_header(jpegStruct,static_cast<boolean>(true));
 	
 	/* Set the decompressor's output color space to Y'CbCr: */
 	jpegStruct->out_color_space=JCS_YCbCr;
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
