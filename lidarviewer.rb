require 'formula'

class Lidarviewer < Formula
  url 'http://keckcaves.org/releases/src/LidarViewer-2.8.tar.gz'
  homepage 'http://keckcaves.org/software/lidarviewer'
  md5 '90d1cceba4ebea0e502f321ebf50f94e'

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = ["INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.2/make"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
