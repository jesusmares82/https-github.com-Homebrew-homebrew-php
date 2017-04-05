class Igbinary < Formula
  desc "Drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.3.tar.gz"
  sha256 "af1f19dbf64e37311099e444f2121b917349cc104abc858e34b094d1a296e179"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "187670cda5b54b642f3d447999cd52155579c5c898bb5ed017ef5ab9a5c4d854" => :sierra
    sha256 "187670cda5b54b642f3d447999cd52155579c5c898bb5ed017ef5ab9a5c4d854" => :el_capitan
    sha256 "187670cda5b54b642f3d447999cd52155579c5c898bb5ed017ef5ab9a5c4d854" => :yosemite
  end

  def install
    include.install Dir["src/*"]
  end
end
