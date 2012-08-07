require 'formula'

class Vrui < Formula
  url 'http://stout.idav.ucdavis.edu/Vrui-2.4-001.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  md5 '997deaefb5eb7b0e6f9345493ce1cf42'
  version "2.4-001"

  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  def install
    name = "Vrui-2.4"
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
