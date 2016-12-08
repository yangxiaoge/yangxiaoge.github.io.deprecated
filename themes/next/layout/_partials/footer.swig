<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-heart"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="http://hexo.io">Hexo</a>') }}
</div>

<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT.{{ theme.scheme }}
  </a>
  <!-- 不蒜子访客数--- 总数 -->
  
  <span id="busuanzi_container_site_pv" style="margin-right:10px;">
    &nbsp;&nbsp; | &nbsp;&nbsp;本站总访问量<span id="busuanzi_value_site_pv"></span>次 
  </span>
  

  <!-- 不蒜子访客数--- 人次 -->
  <!--
  <span id="busuanzi_container_site_uv">
    您是本站第<span id="busuanzi_value_site_uv"></span>位访客
  </span>
  -->
</div>
<!-- 不蒜子 -->
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js">
</script>
<!-- 金山词霸 每日一句 -->     
<!--     
<script type="text/javascript" src="http://open.iciba.com/ds_open.php?id=52493&name=%E7%8F%A0%E7%8F%A0%E3%81%AEBlog&auth=05FEE5A7AF609961317839B36B27973F" charset="utf-8"></script>
-->   