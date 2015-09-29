require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Uuid < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/uuid"
  url "https://pecl.php.net/get/uuid-1.0.3.tgz"
  sha256 "6832c6453efec9800d2dc0bb9786cea02888378e88c15851f79210ef78369ef1"
  head "https://svn.php.net/repository/pecl/uuid/trunk"

  stable do
    patch do
      url "https://gist.github.com/phoenixsong6/4958223/raw/4ad7ebf2bff53887f64ac5be802b85ea5856fa85/php-uuid.patch"
      sha1 "274dfb222ee214a876b2e5bd070b711ce79fd859"
    end
  end
  bottle do
    cellar :any_skip_relocation
    sha256 "8274c2b874cce79db9d075dd6c16567a82e9786520729461384c105659314f91" => :el_capitan
    sha256 "6e23e2d8d403c678f8130cb70e0b3fee1e7f44dbd9c6e7e5520ba2f2fa6462ea" => :yosemite
    sha256 "387afdb246c124e1f8eb892d11f34bd746091c136534d6699bec96498c1c1358" => :mavericks
  end


  head do
    patch do
      url "https://gist.github.com/phoenixsong6/4958223/raw/e802b0e6daebb4403dc77c81e149c5f8c8f49b7e/php-uuid-trunk.patch"
      sha1 "b5fbab7574cf035d318fd932ea5bd4bca0aa44e9"
    end
  end

  def install
    Dir.chdir "uuid-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uuid.so"
    write_config_file if build.with? "config-file"
  end
end
