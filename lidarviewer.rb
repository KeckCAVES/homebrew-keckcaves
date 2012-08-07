require 'formula'

class Lidarviewer < Formula
  url 'http://stout.idav.ucdavis.edu/LidarViewer-2.9.tar.gz'
  homepage 'http://keckcaves.org/software/lidarviewer'
  md5 'ddbdf33e2a9e662e0abee1bcd2ff9595'

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = ["INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.4/make"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
