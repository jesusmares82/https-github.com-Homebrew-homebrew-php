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
    revision 1
    sha256 "dd9966fc9100dbc6a7c0e9ec3796d67123cc729452a872d984f40769222617ea" => :el_capitan
    sha256 "66c97b388d21162ec7433cfc59cd34b0605ffa774c83ebb0c217dd7cd1cb56ab" => :yosemite
    sha256 "7062a3a45347135ceba8c448523e4cd0beb581fea3d826f3551961ac3238bd77" => :mavericks
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
