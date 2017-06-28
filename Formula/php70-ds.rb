require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ds < AbstractPhp70Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.1.10.tar.gz"
  sha256 "9b2ec039dc7140ad7e2bce782b65e2cd04d2f44b10e307beef1465f20e9e6da6"
  head "https://github.com/php-ds/extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2b8c00df9e8c76a67964e1833997cc3e77e8e9750d39e60c48731c6cbc38b8b5" => :el_capitan
    sha256 "14e1a3e4ff5f2beadb6fa86035e582e18f21d6a1099387b53f1c411ad4ee8231" => :yosemite
    sha256 "081281698a8294baf46d9b9896ff2f34b654a21b656067f414e093e282784da3" => :mavericks
  end

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
