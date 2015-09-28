require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Oauth < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-1.2.3.tgz"
  sha256 "86bb5ee37afe672d4532ad784c7f711855c79f0dabf0acacafd5344ab6cf0195"
  head "https://svn.php.net/repository/pecl/oauth/trunk"

  bottle do
    cellar :any_skip_relocation
    sha256 "884be397c28e254fc86e2959f24f027dce3fcdca42fe672c915d2c9d288fbfc6" => :el_capitan
    sha256 "73cba6b88bdeba6a778be52f416a4480fd5dbf8a1d96fe4cd5d86d3a75aa807b" => :yosemite
    sha256 "b8b7a3937070e4188f7fb03064eba16adb6587d7df4a9a1b24c4f6096fc20bf7" => :mavericks
  end

  def install
    Dir.chdir "oauth-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/oauth.so"
    write_config_file if build.with? "config-file"
  end
end
