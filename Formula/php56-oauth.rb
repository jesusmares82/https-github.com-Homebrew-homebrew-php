require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Oauth < AbstractPhp56Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "http://pecl.php.net/package/oauth"
  url "http://pecl.php.net/get/oauth-1.2.3.tgz"
  sha256 "86bb5ee37afe672d4532ad784c7f711855c79f0dabf0acacafd5344ab6cf0195"
  head "https://svn.php.net/repository/pecl/oauth/trunk"

  bottle do
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

  test do
    shell_output("php -m").include?("OAuth")
  end
end
