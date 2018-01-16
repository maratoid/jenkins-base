#!/usr/bin/env groovy
@Library('pipeline')
import net.cnct.pipeline.ApplicationPipeline

applicationPipeline = new ApplicationPipeline(
  steps, 
  'jenkins', 
  this,
  'https://github.com/ZonarSystems/dr-pipeline.git',
  'repo-scan-access',
  [
  ],
  [
  ]
)
applicationPipeline.init()
applicationPipeline.pipelineRun()
