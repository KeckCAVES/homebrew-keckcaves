require 'formula'

class VruiExamples < Formula
  url 'http://stout.idav.ucdavis.edu/Vrui-2.4-004.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  sha1 '0fd094458489fdf558d08a27d093d2669bbf6783'
  version "2.4-004"

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = ["--directory=ExamplePrograms",
            "INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.4/make"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
