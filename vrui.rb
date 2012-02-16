require 'formula'

class Vrui < Formula
  url 'http://www.idav.ucdavis.edu/~okreylos/ResDev/Vrui/Vrui-2.2-003.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  md5 'e894cfa8e021d130fc0f71802cb35635'

  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  def install
    name = "Vrui-2.2"
    args = ["INSTALLDIR=#{prefix}",
            "HEADERINSTALLDIR=#{prefix}/include/#{name}",
            "LIBINSTALLDIR=#{prefix}/lib/#{name}",
            "PLUGININSTALLDIR=#{prefix}/lib/#{name}",
            "ETCINSTALLDIR=#{prefix}/etc/#{name}",
            "SHAREINSTALLDIR=#{prefix}/share/#{name}",
            "DOCINSTALLDIR=#{prefix}/share/doc/#{name}",
            "PNG_BASEDIR=/usr/X11"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
