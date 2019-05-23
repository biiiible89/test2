<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

  <!-- Main Footer -->
  <footer class="main-footer">
  <div class="row">
   	<div class="col-md-12">      
       <div class="nav-tabs-custom">       
         <ul class="nav nav-tabs">
           <li class="header"><i class="fa fa-th"></i>My Story</li>
           <li class=""><a href="#tab_1-1" data-toggle="tab" aria-expanded="false">episode #1</a></li>
           <li class="active"><a href="#tab_2-2" data-toggle="tab" aria-expanded="true">episode #2</a></li>
           <li class=""><a href="#tab_3-2" data-toggle="tab" aria-expanded="false">episode #3</a></li>
         </ul>
         <div class="tab-content">
           <div class="tab-pane" id="tab_1-1">
             <b>How to use:</b>

             <p>Exactly like the original bootstrap tabs except you should use
               the custom wrapper <code>.nav-tabs-custom</code> to achieve this style.</p>
             A wonderful serenity has taken possession of my entire soul,
             like these sweet mornings of spring which I enjoy with my whole heart.
             I am alone, and feel the charm of existence in this spot,
             which was created for the bliss of souls like mine. I am so happy,
             my dear friend, so absorbed in the exquisite sense of mere tranquil existence,
             that I neglect my talents. I should be incapable of drawing a single stroke
             at the present moment; and yet I feel that I never was a greater artist than now.
           </div>
           <!-- /.tab-pane -->
           <div class="tab-pane active" id="tab_2-2">
             The European languages are members of the same family. Their separate existence is a myth.
             For science, music, sport, etc, Europe uses the same vocabulary. The languages only differ
             in their grammar, their pronunciation and their most common words. Everyone realizes why a
             new common language would be desirable: one could refuse to pay expensive translators. To
             achieve this, it would be necessary to have uniform grammar, pronunciation and more common
             words. If several languages coalesce, the grammar of the resulting language is more simple
             and regular than that of the individual languages.
           </div>
           <!-- /.tab-pane -->
           <div class="tab-pane" id="tab_3-2">
             Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
             when an unknown printer took a galley of type and scrambled it to make a type specimen book.
             It has survived not only five centuries, but also the leap into electronic typesetting,
             remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset
             sheets containing Lorem Ipsum passages, and more recently with desktop publishing software
             like Aldus PageMaker including versions of Lorem Ipsum.
           </div>
           <!-- /.tab-pane -->
         </div>
         <!-- /.tab-content -->
       </div>
       <!-- nav-tabs-custom -->
     </div>
     </div>
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<script>
	$('img[alt="User Image"]')
	.attr("src","<%=request.getContextPath()%>/member/picture.do?picture=${loginUser.picture}");
</script>
<!--

//-->
</script>
<!-- Bootstrap 3.3.7 -->
<script src="<%=request.getContextPath()%>/resources/bootstrap/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/resources/bootstrap/dist/js/adminlte.min.js"></script>

<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>