<!--

    This Source Code Form is subject to the terms of the Mozilla Public License,
    v. 2.0. If a copy of the MPL was not distributed with this file, You can
    obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
    the terms of the Healthcare Disclaimer located at http://openmrs.org/license.

    Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
    graphic logo is a trademark of OpenMRS Inc.

-->

<script type="text/javascript">
    emr.loadMessages(["casereport.submitted"]);
    emr.loadMessages(["casereport.report.form.title"]);
</script>

<h2 id="casereport-reportTitle" />

<form class="simple-form-ui" name="caseReportForm" novalidate ng-submit="submitCaseReport()">
    {{ updateFormTitle(caseReport.patient.person.display) }}
    {{ setTriggers(caseReport.reportForm.triggerAndDateCreatedMap) }}
    <table class="casereport-form-table" cellpadding="0" cellspacing="0">
        <tr>
            <th valign="top">${ui.message("general.name")}</th>
            <td valign="top">{{ caseReport.patient.person.display }}</td>
        </tr>
        <tr>
            <th valign="top">${ui.message("Patient.identifier")}</th>
            <td valign="top">{{ caseReport.reportForm.patientIdentifier }}</td>
        </tr>
        <tr>
            <th valign="top">${ui.message("Person.gender")}</th>
            <td valign="top">{{ caseReport.reportForm.gender }}</td>
        </tr>
        <tr>
            <th valign="top">${ui.message("casereport.birthdate")}</th>
            <td valign="top">{{ formatDate(caseReport.reportForm.birthdate) }}</td>
        </tr>
        <tr ng-show="caseReport.reportForm.dead">
            <th valign="top">${ui.message("Person.dead")}</th>
            <td valign="top">${ui.message("general.yes")}</td>
        </tr>
        <tr ng-show="caseReport.reportForm.dead && caseReport.reportForm.deathdate">
            <th valign="top">${ui.message("casereport.deathdate")}</th>
            <td valign="top">{{ formatDate(caseReport.reportForm.deathdate) }}</td>
        </tr>
        <tr ng-show="caseReport.reportForm.dead && caseReport.reportForm.causeOfDeath">
            <th valign="top">${ui.message("casereport.causeOfDeath")}</th>
            <td valign="top">{{ formatDate(caseReport.reportForm.causeOfDeath) }}</td>
        </tr>
        <tr>
            <th valign="top">${ui.message("casereport.triggers")}</th>
            <td valign="top">
                <span>
                    <span ng-repeat="trigger in triggers track by \$index">
                        <span class="casereport-trigger-lozenge">
                            {{ trigger }}
                            <a class="casereport-no-underline" ng-show="triggers.length > 1">
                                <i class="icon-remove delete-action" title="${ui.message("general.remove")}"
                                   ng-click="remove(\$index)" />
                            </a>
                        </span>
                    </span>
                 </span>
            </td>
        </tr>
        <tr ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndViralLoadMap) > 0
                    || getMapSize(caseReport.reportForm.mostRecentDateAndCd4CountMap) > 0
                    || getMapSize(caseReport.reportForm.mostRecentDateAndHivTestMap) > 0">
            <th valign="top">${ui.message("casereport.data")}</th>
            <td valign="top">
                <br />
                <table id="casereport-data-table" cellpadding="0" cellspacing="0">
                    <tr>
                        <th valign="top">${ui.message("casereport.viralLoad")}</th>
                        <td valign="top" ng-repeat="key in getObjectKeys(caseReport.reportForm.mostRecentDateAndViralLoadMap)">
                            {{ caseReport.reportForm.mostRecentDateAndViralLoadMap[key] }} <span class="casereport-small-faint">({{ key | serverDate}})</span>
                        </td>
                        <td ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndViralLoadMap) < 3">
                            <span ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndViralLoadMap) == 0">
                                ${ui.message("casereport.none.found")}
                            </span>
                        </td>
                        <td ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndViralLoadMap) < 2"></td>
                        <td ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndViralLoadMap) < 1"></td>
                    </tr>
                    <tr>
                        <th valign="top">${ui.message("casereport.cd4Count")}</th>
                        <td valign="top" ng-repeat="key in getObjectKeys(caseReport.reportForm.mostRecentDateAndCd4CountMap)">
                            {{ caseReport.reportForm.mostRecentDateAndCd4CountMap[key] }} <span class="casereport-small-faint">({{ key | serverDate}})</span>
                        </td>
                        <td ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndCd4CountMap) < 3">
                            <span ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndCd4CountMap) == 0">
                                ${ui.message("casereport.none.found")}
                            </span>
                        </td>
                        <td ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndCd4CountMap) < 2"></td>
                        <td ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndCd4CountMap) < 1"></td>
                    </tr>
                    <tr>
                        <th valign="top">${ui.message("casereport.hivTest")}</th>
                        <td valign="top" ng-repeat="key in getObjectKeys(caseReport.reportForm.mostRecentDateAndHivTestMap)">
                            {{ caseReport.reportForm.mostRecentDateAndHivTestMap[key] }} <span class="casereport-small-faint">({{ key | serverDate}})</span>
                        </td>
                        <td ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndHivTestMap) < 3">
                            <span ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndHivTestMap) == 0">
                                ${ui.message("casereport.none.found")}
                            </span>
                        </td>
                        <td ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndHivTestMap) < 2"></td>
                        <td ng-show="getMapSize(caseReport.reportForm.mostRecentDateAndHivTestMap) < 1"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr ng-show="caseReport.reportForm.mostRecentHivWhoStage">
            <th valign="top">${ui.message("casereport.whoClassification")}</th>
            <td valign="top">{{ caseReport.reportForm.mostRecentHivWhoStage }}</td>
        </tr>
        <tr ng-show="caseReport.reportForm.currentHivMedications.length > 0">
            <th valign="top">${ui.message("casereport.arvs")}</th>
            <td valign="top">{{ caseReport.reportForm.currentHivMedications | omrs.display }}</td>
        </tr>
        <tr ng-show="caseReport.reportForm.mostRecentArvStopReason">
            <th valign="top">${ui.message("casereport.reasonArvsStopped")}</th>
            <td valign="top">{{ caseReport.reportForm.mostRecentArvStopReason }}</td>
        </tr>
        <tr ng-show="caseReport.reportForm.previousSubmittedCaseReports.length > 0">
            <th valign="top">${ui.message("casereport.previousCaseReports")}</th>
            <td valign="top">{{ caseReport.reportForm.previousSubmittedCaseReports | omrs.display }}</td>
        </tr>
        <tr ng-show="caseReport.reportForm.lastVisitDate">
            <th valign="top">${ui.message("casereport.lastVisit")}</th>
            <td valign="top">{{ caseReport.reportForm.lastVisitDate | serverDate}}</td>
        </tr>
        <tr>
            <th class="casereport-row-separator"></th>
            <td class="casereport-row-separator"></td>
        </tr>
        <tr>
            <th valign="top">${ui.message("casereport.signature")}</th>
            <td valign="top">
                ${ui.format(context.authenticatedUser)}
                <span class="right">
                    <button type="button" class="cancel" ui-sref="list">${ui.message('general.cancel')}</button>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="submit" class="right">${ui.message('general.submit')}</button>
                </span>
            </td>
        </tr>
    </table>
</form>