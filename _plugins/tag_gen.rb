module Jekyll

  class TagIndex < Page    
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = "&ldquo;"+tag+"&rdquo;"
      self.data['description'] = ""
    end
  end

  class TagGenerator < Generator
    safe true
    
    def generate(site)
      if site.layouts.key? 'tag'
        dir = 'tag'
        site.tags.keys.each do |tag|
          write_tag_index(site, File.join(dir, tag), tag)
        end
      end
      #FileUtils.rm_r '/home/linguofeng/workspace/linguofeng.github.com/tag/'
      #FileUtils.cp_r '/home/linguofeng/workspace/linguofeng.github.com/_site/tag/', '/home/linguofeng/workspace/linguofeng.github.com/'
    end
  
    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end

end