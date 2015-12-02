require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Propro < AbstractPhp55Extension
  init
  desc "A reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://pecl.php.net/get/propro-1.0.0.tgz"
  sha256 "9825d50ab4bb214428cd11c14c2f389c16aded09db16d266f27f147a7f2371f2"

  head "https://git.php.net/repository/pecl/php/propro.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "3beededc34dc41516999f149ca84c364aabf87a66c388d1f234e451a7f5030ce" => :el_capitan
    sha256 "d94d2fbf423971a62ee1d7b99a3a209926e089f6b6eca0296b4418679215df2a" => :yosemite
    sha256 "d6f326aec4aff7a4856a89cbfe39c7b853721b2018eceddc46f162e4f3ba72ac" => :mavericks
  end

  def install
    Dir.chdir "propro-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
