require 'formula'

class Vrui < Formula
  ver = "2.6-002"
  pkgver = "1"

  homepage 'http://keckcaves.org/software/vrui'
  url "https://github.com/KeckCAVES/Vrui.git", :revision => "v#{ver}"
  version "#{ver}-#{pkgver}"

  depends_on :x11 => '2.7.4'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  # ImageReader is broken.
  # RazerHydra VRDevice needs libusb1.0 include path.
  def patches
    DATA
  end

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
    args << "PNG_BASEDIR=#{MacOS::X11.prefix}"
    args << "X11_BASEDIR=#{MacOS::X11.prefix}"
    args << "GL_BASEDIR=#{MacOS::X11.prefix}"
    args << "GLU_BASEDIR=#{MacOS::X11.prefix}"

    args << "SHOWCOMMAND=1"

    system "make", *args
    system "make", *(args+["install"])
  end
end

__END__
diff --git a/makefile b/makefile
index 8ff4c31..629ec5e 100644
--- a/makefile
+++ b/makefile
@@ -887,6 +887,9 @@ IMAGES_HEADERS = $(wildcard Images/*.h) \
 
 IMAGES_SOURCES = $(wildcard Images/*.cpp)
 
+IMAGES_HEADERS := $(filter-out Images/ImageReader.h,$(IMAGES_HEADERS))
+IMAGES_SOURCES := $(filter-out Images/ImageReader.cpp,$(IMAGES_SOURCES))
+
 $(IMAGES_SOURCES): config
 
 $(call LIBRARYNAME,libImages): PACKAGES += $(MYIMAGES_DEPENDS)
@@ -1332,6 +1335,7 @@ $(VRDEVICESDIR)/libWiimoteTracker.$(PLUGINFILEEXT): PLUGINDEPENDENCIES += $(BLUE
 $(VRDEVICESDIR)/libWiimoteTracker.$(PLUGINFILEEXT): $(OBJDIR)/VRDeviceDaemon/VRDevices/Wiimote.o \
                                                     $(OBJDIR)/VRDeviceDaemon/VRDevices/WiimoteTracker.o
 
+$(VRDEVICESDIR)/libRazerHydraDevice.$(PLUGINFILEEXT): PACKAGES += MYUSB
 $(VRDEVICESDIR)/libRazerHydraDevice.$(PLUGINFILEEXT): PLUGINDEPENDENCIES += $(MYUSB_LIBDIR) $(MYUSB_LIBS)
 ifneq ($(SYSTEM_HAVE_RPATH),0)
   ifneq ($(USE_RPATH),0)
