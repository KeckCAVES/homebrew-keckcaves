# This is named 'visualizer' and not '3dvisualizer' only because
# of limitations in class naming between ruby and homebrew.

require 'formula'

class Visualizer < Formula
  ver = "1.12"
  pkgver = "1"

  homepage 'http://keckcaves.org/software/3dvisualizer'
  url "https://github.com/KeckCAVES/3DVisualizer.git", :revision => "v#{ver}"
  version "#{ver}-#{pkgver}"

  depends_on 'KeckCAVES/keckcaves/vrui'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  option 'no-shaders',\
      "Use fixed OpenGL functionality instead of GLSL shaders\n\t"\
      "for some visualization algorithms, especially volume rendering.\n\t"\
      "This flag should only be set for use on less powerful graphics hardware."
  
  def install
    inreplace 'makefile', 'UNSUPPORTED_MODULE_NAMES =', 'MODULE_NAMES +='
    args = []
    args << "INSTALLDIR=#{prefix}"
    args << "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/vrui/make"
    args << "JPEG_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "TIFF_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "LIBUSB1_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "PNG_BASEDIR=#{MacOS::X11.prefix}"
    args << "X11_BASEDIR=#{MacOS::X11.prefix}"
    args << "GL_BASEDIR=#{MacOS::X11.prefix}"
    args << "GLU_BASEDIR=#{MacOS::X11.prefix}"
    args << "USE_SHADERS=0" if build.include? 'no-shaders'
    args << "SHOWCOMMAND=1"
    system "make", *args
    system "make", *(args+["install"])
  end

  def caveats; <<-EOS.undent
    Please note that the name of the installed executable is "3DVisualizer".
    EOS
  end
end
