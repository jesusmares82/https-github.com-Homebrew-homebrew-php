require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yaml < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/yaml'
  url 'http://pecl.php.net/get/yaml-1.1.1.tgz'
  sha1 '7b095f76fe0e4b3b9072c7f0099a203265686f3a'
  head 'https://svn.php.net/repository/pecl/yaml/trunk'

  depends_on 'libyaml'

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
