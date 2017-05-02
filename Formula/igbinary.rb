class Igbinary < Formula
  desc "Drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.4.tar.gz"
  sha256 "7b71e60aeada2b9729f55f3552da28375e3c5c66194b2c905af15c3756cf34c8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d1d2f072a296a5081a1b15017030544771fd1d8357b8bdb1854533266c060efe" => :sierra
    sha256 "924ea52c92530ed20c9b5fb191828403eeea0404e14fee04ca70064485cb88d6" => :el_capitan
    sha256 "924ea52c92530ed20c9b5fb191828403eeea0404e14fee04ca70064485cb88d6" => :yosemite
  end

  def install
    include.install Dir["src/*"]
  end
end
