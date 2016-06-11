require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Propro < AbstractPhp56Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-1.0.2.tar.gz"
  sha256 "35b1d0881927049b3c7a14dc28306e2788f9b2bc937b1ef18e533a3bef8befce"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "af7868160b8896651c20c5a7bf1cf859be876b581187591ded8d363be0ff3bf3" => :el_capitan
    sha256 "3b34cf3548040739c44cbd68ce6b0d45ec34abab23f5df789dcf7de8a0638f7b" => :yosemite
    sha256 "e91ff23f81f59b10ebc0346a8cb7bf2f8ef93d823880b699801175d8549cfc6c" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
