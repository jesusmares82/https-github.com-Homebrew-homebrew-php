require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Oauth < AbstractPhp54Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-1.2.3.tgz"
  sha256 "86bb5ee37afe672d4532ad784c7f711855c79f0dabf0acacafd5344ab6cf0195"
  head "https://svn.php.net/repository/pecl/oauth/trunk"

  bottle do
    cellar :any_skip_relocation
    sha256 "0d804974d78becfec24b58aa808d8cd8426427cc795060b531b49ad4d5d5a11f" => :el_capitan
    sha256 "82607f6c2020b3324f8e3913ec8f464e833c8ab2bc4e9b6b87a11c868aa64ee6" => :yosemite
    sha256 "fe822d2dbeb3f57e94c99bee7d514ee3f15b6be274b8af451d3c177d391a37b0" => :mavericks
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
