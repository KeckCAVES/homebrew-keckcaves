require 'formula'

class Vrui < Formula
  url 'http://www.idav.ucdavis.edu/~okreylos/ResDev/Vrui/Vrui-2.1-001.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  md5 'e0aeb50c3a43b1f7189a45a9471ef08a'

  depends_on 'jpeg'
  depends_on 'libtiff'

  def install
    system "make", "INSTALLDIR=#{prefix}", "PNG_BASEDIR=/usr/X11"
    system "make", "INSTALLDIR=#{prefix}", "install"
  end
end
