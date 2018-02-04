# 讓輸出有點顏色容易看而已
class String
  def blue;           "\e[34m#{self}\e[0m" end
  def bold;           "\e[1m#{self}\e[22m" end
end

def print_all_files(file_path, depth_index = 0)
  # 初始化計數器
  directories_count = 0
  files_count = 0

  # 獲取當前目錄所有元素，并刪除「當前目錄」與「上級目錄」
  files_list = Dir.foreach(file_path).to_a.sort()
  files_list.delete(".")
  files_list.delete("..")

  # 遍歷輸出
  for filename in files_list
    # 打印縮進
    print "│  " * depth_index
    # 如果是最後一個元素就改變符號
    if filename == files_list[-1]
      print "└─ "
    else
      print "├─ "
    end
    # 使用絕對路徑判斷該元素是否為「目錄」
    if File.directory?(File.expand_path(filename, file_path))
      directories_count = directories_count + 1
      puts filename.blue.bold
      # 返回下級目錄總共的目錄，文件計數
      if depth_index < 2
        count_result = print_all_files(File.expand_path(filename, file_path), depth_index + 1)
        directories_count += count_result[0]
        files_count += count_result[1]
      end
    else
      files_count = files_count + 1
      puts filename
    end
  end
  return directories_count, files_count
end

puts "."
a, b = print_all_files(Dir.pwd)
puts "\nTotal: #{a} directories, #{b} files"
