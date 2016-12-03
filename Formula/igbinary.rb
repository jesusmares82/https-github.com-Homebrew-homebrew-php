class Igbinary < Formula
  desc "Drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.1.tar.gz"
  sha256 "9c66e6bb8225bf559148661d8ef81451e5f67f0a565d975dc0918abd8c35e0ed"
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
