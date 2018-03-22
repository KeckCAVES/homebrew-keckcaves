require 'formula'

class VruiExamplesBlueMarbleTex < Formula
  homepage 'http://keckcaves.org/data/'
  url 'https://openclipart.org/image/800px/svg_to_png/218100/The-Blue-Marble.png'
  sha256 '8694ab83280f70f9d198e2920595e65436f18e71da08b705a9836db279d739ba'
  version '1'
end

class VruiExamples < Formula
  ver = "3.1-002"
  pkgver = "1"

  homepage 'http://keckcaves.org/software/vrui'
  url "https://github.com/KeckCAVES/Vrui.git", :revision => "v#{ver}"
  version "#{ver}-#{pkgver}"

  depends_on "KeckCAVES/keckcaves/vrui"

  def install
    args = []
    args << "--directory=ExamplePrograms"
    args << "INSTALLDIR=#{prefix}"
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

    topodir = share+"VruiExamplePrograms"
    name = 'vrui-examples-blue-marble-tex'
    spec = :stable
    VruiExamplesBlueMarbleTex.new(name, Formula.path(name), spec).brew { topodir.install Dir['BlueMarble.png'] }
    ln_sf topodir+"BlueMarble.png", topodir+"EarthTopography.png"
  end
end
