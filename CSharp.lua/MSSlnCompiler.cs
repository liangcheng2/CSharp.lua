// modified by lch begin

using System;
using System.Collections.Generic;
using System.Collections.Concurrent;
using System.Collections.Immutable;
using System.Diagnostics.Contracts;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.CodeAnalysis.Emit;

using Microsoft.CodeAnalysis.MSBuild;
//using Microsoft.CodeAnalysis.MSBuild;
//using Microsoft.Build.Locator;

//using Microsoft.Build.Execution;
//using Microsoft.Build.Framework;
//using Microsoft.Build.Utilities;
//using Microsoft.Build.Evaluation;


namespace CSharpLua {
  public static class MSCompiler {

    //public static string Compile(string solution_name, string logfile) {
    //  string projectFileName = @"...\ConsoleApplication3\ConsoleApplication3.sln";

    //  ProjectCollection pc = new ProjectCollection();

    //  Dictionary<string, string> GlobalProperty = new Dictionary<string, string>();

    //  GlobalProperty.Add("Configuration", "Debug");

    //  GlobalProperty.Add("Platform", "x86");



    //  BuildRequestData BuidlRequest = new BuildRequestData(projectFileName, GlobalProperty, null, new string[] { "Build" }, null);



    //  BuildResult buildResult = BuildManager.DefaultBuildManager.Build(new BuildParameters(pc), BuidlRequest);
    //}

    public static CSharpCompilation CompileProject(string projectPath) {
      Dictionary<string, string> properties = new Dictionary<string, string>();
      properties.Add("Configuration", "Debug");
      properties.Add("Platform", "AnyCPU");
      MSBuildWorkspace workspace = MSBuildWorkspace.Create(properties);

      Project project = workspace.OpenProjectAsync(projectPath).Result;
      var projectCompilation = project.GetCompilationAsync().Result as CSharpCompilation;
      using (var stream = new MemoryStream()) {
        EmitResult result = projectCompilation.Emit(stream);
        if (result.Success) {
          return projectCompilation;
        } else {
          Console.WriteLine(projectCompilation.GetDiagnostics());
          throw new CompilationErrorException(result.Diagnostics.ToString());
        }
      }
    }

    public static List<CSharpCompilation> CompileSln(string slnPath) {
      //MSBuildLocator.RegisterDefaults();

      Dictionary<string, string> properties = new Dictionary<string, string>();
      properties.Add("Configuration", "Debug");
      properties.Add("Platform", "AnyCPU");
      MSBuildWorkspace workspace = MSBuildWorkspace.Create(properties);

      Solution solution = workspace.OpenSolutionAsync(slnPath).Result;
      ProjectDependencyGraph projectGraph = solution.GetProjectDependencyGraph();
      Dictionary<string, Stream> assemblies = new Dictionary<string, Stream>();

      var projectCompilations = new List<CSharpCompilation>();
      foreach (ProjectId projectId in projectGraph.GetTopologicallySortedProjects()) {
        CSharpCompilation projectCompilation = solution.GetProject(projectId).GetCompilationAsync().Result as CSharpCompilation;
        if (null != projectCompilation && !string.IsNullOrEmpty(projectCompilation.AssemblyName)) {
          using (var stream = new MemoryStream()) {
            EmitResult result = projectCompilation.Emit(stream);
            if (result.Success) {
              projectCompilations.Add(projectCompilation);
              //string fileName = string.Format("{0}.dll", projectCompilation.AssemblyName);

              //using (FileStream file = File.Create(slnPath + '\\' + fileName)) {
              //  stream.Seek(0, SeekOrigin.Begin);
              //  stream.CopyTo(file);
              //}
            } else {
              foreach (var diagnostic in projectCompilation.GetDiagnostics()
                .Where(d => d.Severity == DiagnosticSeverity.Error)) {
                Console.WriteLine(diagnostic);
              }
              throw new Exception(result.Diagnostics.ToString());
            }
          }
        }
      }

      return projectCompilations;
    }
  }

  //public static string[] GetProjectsFromSln(string slnPath) {

  //}
  //public static void CompileProj(string projPath) {

  //}
}


// modified by lch end
