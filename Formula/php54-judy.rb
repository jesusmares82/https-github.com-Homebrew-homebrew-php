require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Judy < AbstractPhp54Extension
  init
  desc "PHP Extension for libJudy."
  homepage "https://github.com/orieg/php-judy"
  url "https://pecl.php.net/get/Judy-1.0.2.tgz"
  sha256 "6b913af2c44ac84a2224fecf8a81ddcb0c753252cafd153cb0e9d7c33a333118"
  head "https://github.com/orieg/php-judy.git"

  bottle do
    cellar :any
    revision 1
    sha256 "2bb10260ea4aeec0e43d9f1d2a68fdd0737fb0235d9e635085355f7984ec25c4" => :el_capitan
    sha256 "7f883b680e51584e53a09d31e901cc9491adadba0fe6a2f258594afd9e512d92" => :yosemite
    sha256 "4d0c7ec91ba71cf9cca1b7505bbeb7d8ef61beee34ac72d6fad9389e97c1a3d4" => :mavericks
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
