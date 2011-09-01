require 'formula'

class VruiExamples < Formula
  url 'http://www.idav.ucdavis.edu/~okreylos/ResDev/Vrui/Vrui-2.1-001.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  md5 'e0aeb50c3a43b1f7189a45a9471ef08a'

#  depends_on 'vrui'

  def install
    system "make", "--directory=ExamplePrograms", "INSTALLDIR=#{prefix}", "VRUIDIR=#{HOMEBREW_PREFIX}"
    system "make", "--directory=ExamplePrograms", "INSTALLDIR=#{prefix}", "VRUIDIR=#{HOMEBREW_PREFIX}", "install"
  end
end
