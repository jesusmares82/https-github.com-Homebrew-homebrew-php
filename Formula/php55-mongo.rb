require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongo < AbstractPhp55Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.12.tgz"
  sha256 "3fec10526ed02ce0e54c4623839e35bfab17d16cb9e8a48c7fee126be351c990"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "b852a69b5c6978c9af9de8630fe0a5dd7d29ec0c290a93f8ff7634251e7d690d" => :el_capitan
    sha256 "83f23188971e8872913efacbeffeafb904bdde594e08d6f26f2c206c47ecddf6" => :yosemite
    sha256 "a2976210ccf5e9c8a617916254a54ca80e43cd1fbe9ef4c608f49ae04777ee27" => :mavericks
  end

  def install
    Dir.chdir "mongo-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mongo.so"
    write_config_file if build.with? "config-file"
  end
end
