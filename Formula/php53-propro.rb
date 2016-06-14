require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Propro < AbstractPhp53Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-1.0.2.tar.gz"
  sha256 "35b1d0881927049b3c7a14dc28306e2788f9b2bc937b1ef18e533a3bef8befce"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "d9f112c599cd87ff8119ca406eba31783b7f78bc6792abdff9636cc95454ce0e" => :el_capitan
    sha256 "08c43e0e66a9795e0bae45f467a7fd9850b3eae064ac9ec31a948ae156f67473" => :yosemite
    sha256 "6ce49487a3a43e6d88e775fa07adcddb76918c33a056f9f5c7860d88ead18a90" => :mavericks
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
