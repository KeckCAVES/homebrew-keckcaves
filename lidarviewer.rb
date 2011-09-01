require 'formula'

class Lidarviewer < Formula
  url 'http://stout.idav.ucdavis.edu/LidarViewer-2.7.tar.gz'
  homepage 'http://keckcaves.org/software/lidarviewer'
  md5 '5fa1daa64ef9eb8ce275c19919abc9ea'

#  depends_on 'vrui'

  def install
    system "make", "INSTALLDIR=#{prefix}", "VRUIDIR=#{HOMEBREW_PREFIX}"
    system "make", "INSTALLDIR=#{prefix}", "VRUIDIR=#{HOMEBREW_PREFIX}", "install"
  end
end
