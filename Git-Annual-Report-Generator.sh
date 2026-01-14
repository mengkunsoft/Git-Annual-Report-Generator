# Git Annual Report Generator 
# 生成2025年度Git仓库提交分析报告
# 当前日期：2026年1月12日
 
REPORT_FILE="git_annual_report_2025.md"
YEAR_START="2025-01-01"
YEAR_END="2025-12-31"
 
# 初始化报告文件 
echo "# Git本地仓库年度提交分析报告 (2025)" > $REPORT_FILE
echo "**生成日期**：2026年1月12日 13:53" >> $REPORT_FILE 
echo "**分析周期**：${YEAR_START} 至 ${YEAR_END}" >> $REPORT_FILE 
echo "" >> $REPORT_FILE 
 
# 一、基础提交统计 
echo "## 一、基础提交统计" >> $REPORT_FILE 
 
# 总提交次数
total_commits=$(git log --since="$YEAR_START" --until="$YEAR_END" --pretty=oneline | wc -l)
echo "1. **总提交次数**: ${total_commits}次" >> $REPORT_FILE
 
# 作者统计 
echo "2. **活跃作者排名**:" >> $REPORT_FILE 
git shortlog -sn --since="$YEAR_START" --until="$YEAR_END" | while read -r commits author; do 
  percentage=$((commits*100/total_commits))
  echo "   - ${author}: ${commits}次 (占比${percentage}%)" >> $REPORT_FILE 
done 
 
# 提交高峰日 
echo "3. **提交高峰日**:" >> $REPORT_FILE 
git log --since="$YEAR_START" --until="$YEAR_END" --pretty=format:%ad --date=short | sort | uniq -c | sort -nr | head -5 | while read -r count date; do
  echo "   - ${date}: ${count}次提交" >> $REPORT_FILE
done
echo "" >> $REPORT_FILE
 
# 二、时间维度分析
echo "## 二、时间维度分析" >> $REPORT_FILE
 
# 月度提交趋势
echo "### 1. 月度提交趋势" >> $REPORT_FILE 
echo "| 月份 | 提交次数 |" >> $REPORT_FILE
echo "|------|---------|" >> $REPORT_FILE
git log --since="$YEAR_START" --until="$YEAR_END" --pretty=format:%ad --date=short | cut -d- -f1-2 | sort | uniq -c | sort -k2 | while read -r count month; do 
  echo "| ${month} | ${count} |" >> $REPORT_FILE
done
echo "" >> $REPORT_FILE
 
# 每周提交模式
echo "### 2. 每周提交模式" >> $REPORT_FILE 
echo "| 星期 | 提交次数 |" >> $REPORT_FILE
echo "|------|---------|" >> $REPORT_FILE
git log --since="$YEAR_START" --until="$YEAR_END" --pretty=format:%ad --date=short | awk '{print strftime("%A", mktime($0" 0 0 0"))}' | sort | uniq -c | while read -r count weekday; do 
  echo "| ${weekday} | ${count} |" >> $REPORT_FILE 
done 
echo "" >> $REPORT_FILE 
 
# 每日时段分析 
echo "### 3. 每日时段分析" >> $REPORT_FILE
echo "| 时段 | 提交次数 |" >> $REPORT_FILE 
echo "|------|---------|" >> $REPORT_FILE 
git log --since="$YEAR_START" --until="$YEAR_END" --pretty=format:%ad --date=format:'%H' | sort | uniq -c | sort -k2 | while read -r count hour; do 
  echo "| ${hour}:00-${hour}:59 | ${count} |" >> $REPORT_FILE
done
echo "" >> $REPORT_FILE
 
# 三、代码变更分析
echo "## 三、代码变更分析" >> $REPORT_FILE
 
# 代码增删统计 
echo "### 1. 代码增删统计" >> $REPORT_FILE 
git log --since="$YEAR_START" --until="$YEAR_END" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "- 总添加行数: %s\n- 总删除行数: %s\n- 净增代码行数: %s\n", add, subs, loc }' >> $REPORT_FILE
echo "" >> $REPORT_FILE
 
# 文件变更统计
echo "### 2. 文件变更统计" >> $REPORT_FILE 
echo "#### 最频繁修改文件Top 10:" >> $REPORT_FILE 
git log --since="$YEAR_START" --until="$YEAR_END" --name-only --pretty=format: | sort | uniq -c | sort -nr | head -10 | while read -r count file; do
  echo "- ${file} (${count}次)" >> $REPORT_FILE
done
echo "" >> $REPORT_FILE
 
# 四、分支与合并分析 
echo "## 四、分支与合并分析" >> $REPORT_FILE
merge_commits=$(git log --since="$YEAR_START" --until="$YEAR_END" --merges --pretty=oneline | wc -l)
echo "- 合并操作次数: ${merge_commits}" >> $REPORT_FILE 
echo "- 新分支创建统计:" >> $REPORT_FILE 
git log --since="$YEAR_START" --until="$YEAR_END" --pretty=format:"%h %ad %s" --date=short | grep -i "branch" | head -5 >> $REPORT_FILE
echo "" >> $REPORT_FILE
 
# 五、提交消息分析
echo "## 五、提交消息分析" >> $REPORT_FILE
echo "### 1. 提交消息长度统计" >> $REPORT_FILE 
avg_msg_length=$(git log --since="$YEAR_START" --until="$YEAR_END" --pretty=format:%s | awk '{ total += length($0); count++ } END { print int(total/count) }')
echo "- 平均提交消息长度: ${avg_msg_length}字符" >> $REPORT_FILE 
 
echo "### 2. 高频关键词Top 10" >> $REPORT_FILE 
git log --since="$YEAR_START" --until="$YEAR_END" --pretty=format:%s | tr '[:upper:]' '[:lower:]' | tr -sc '[:alpha:]' '\n' | sort | uniq -c | sort -nr | head -10 | while read -r count word; do
  echo "- ${word} (${count}次)" >> $REPORT_FILE 
done 
echo "" >> $REPORT_FILE 
 
# 六、开发节奏分析 
echo "## 六、开发节奏分析" >> $REPORT_FILE 
echo "### 提交间隔统计" >> $REPORT_FILE 
git log --since="$YEAR_START" --until="$YEAR_END" --pretty=format:%ad --date=raw | awk '{print $1}' | tac | awk 'NR>1{print ($1-prev)/3600} {prev=$1}' | sort -n | awk '
  BEGIN { count=0; total=0; max=0 } 
  { total += $1; count++; if($1>max) max=$1 } 
  END { 
    avg = total/count;
    printf "- 平均提交间隔: %.1f小时\n", avg;
    printf "- 最长无提交间隔: %.1f小时\n", max;
  }' >> $REPORT_FILE
echo "" >> $REPORT_FILE
 
# 七、建议与改进 
echo "## 七、建议与改进" >> $REPORT_FILE 
echo "1. **活跃度优化**: 根据月度/周分析结果调整开发节奏" >> $REPORT_FILE 
echo "2. **提交质量**: 优化提交消息规范，增加描述性" >> $REPORT_FILE
echo "3. **分支策略**: 根据分支使用情况优化工作流程" >> $REPORT_FILE
echo "4. **团队协作**: 平衡各成员贡献度" >> $REPORT_FILE 
 
echo "" >> $REPORT_FILE
echo "报告生成完成，请查看 ${REPORT_FILE}"
 
# 结束脚本 
exit 0 