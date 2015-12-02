require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Judy < AbstractPhp53Extension
  init
  desc "PHP Extension for libJudy."
  homepage "https://github.com/orieg/php-judy"
  url "https://pecl.php.net/get/Judy-1.0.2.tgz"
  sha256 "6b913af2c44ac84a2224fecf8a81ddcb0c753252cafd153cb0e9d7c33a333118"
  head "https://github.com/orieg/php-judy.git"

  bottle do
    cellar :any
    sha256 "2a8c6d20b113c80c54b01ec614e3883729e93e375c9b4f34454833ad8a10aef0" => :el_capitan
    sha256 "4a526968a9648110969d46bd9ef196a8fd982ac1f15bee4330e007d28d975182" => :yosemite
    sha256 "19493775e2e1bb9b85dc26c46abb1f120a437102dd7fcd22c34ea80557c034a4" => :mavericks
  end

  depends_on "judy"

  def install
    Dir.chdir "judy-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/judy.so"
    write_config_file if build.with? "config-file"
  end
end
