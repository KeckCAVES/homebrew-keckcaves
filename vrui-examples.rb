require 'formula'

class VruiExamples < Formula
  url 'http://keckcaves.org/releases/src/Vrui-2.2-003-1.tar.bz2'
  homepage 'http://keckcaves.org/software/vrui'
  md5 'e894cfa8e021d130fc0f71802cb35635'
  version "2.2-003-1"

#  depends_on 'vrui'

  def install
    args = ["--directory=ExamplePrograms",
            "INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.2/make"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
