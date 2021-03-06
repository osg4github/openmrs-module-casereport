/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.casereport.web.rest.v1_0.resource;

import org.openmrs.api.context.Context;
import org.openmrs.module.casereport.CaseReport;
import org.openmrs.module.casereport.api.CaseReportService;
import org.openmrs.module.casereport.web.rest.StatusChange;
import org.openmrs.module.webservices.rest.web.RequestContext;
import org.openmrs.module.webservices.rest.web.annotation.SubResource;
import org.openmrs.module.webservices.rest.web.representation.Representation;
import org.openmrs.module.webservices.rest.web.resource.api.PageableResult;
import org.openmrs.module.webservices.rest.web.resource.impl.DelegatingResourceDescription;
import org.openmrs.module.webservices.rest.web.resource.impl.DelegatingSubResource;
import org.openmrs.module.webservices.rest.web.response.GenericRestException;
import org.openmrs.module.webservices.rest.web.response.ResourceDoesNotSupportOperationException;
import org.openmrs.module.webservices.rest.web.response.ResponseException;

@SubResource(parent = CaseReportResource.class, path = "statuschange", supportedClass = StatusChange.class, supportedOpenmrsVersions = {
        "1.8.*", "1.9.*", "1.10.*", "1.11.*" })
public class StatusChangeResource extends DelegatingSubResource<StatusChange, CaseReport, CaseReportResource> {
	
	/**
	 * @see DelegatingSubResource#getRepresentationDescription(Representation)
	 */
	@Override
	public DelegatingResourceDescription getRepresentationDescription(Representation rep) {
		DelegatingResourceDescription description = new DelegatingResourceDescription();
		description.addRequiredProperty("action");
		description.addProperty("submitter");
		description.addProperty("triggersToExclude");
		description.addProperty("implementationId");
		description.addProperty("implementationName");
		description.addProperty("reportForm");
		return description;
	}
	
	/**
	 * @see DelegatingSubResource@getCreatableProperties()
	 */
	@Override
	public DelegatingResourceDescription getCreatableProperties() throws ResourceDoesNotSupportOperationException {
		return getRepresentationDescription(null);
	}
	
	/**
	 * @see DelegatingSubResource#save(Object)
	 */
	@Override
	public StatusChange save(StatusChange delegate) {
		if (StatusChange.Action.SUBMIT == delegate.getAction()) {
			CaseReport caseReport = getParent(delegate);
			Context.getService(CaseReportService.class).submitCaseReport(caseReport, delegate.getTriggersToExclude(),
			    delegate.getSubmitter(), delegate.getImplementationId(), delegate.getImplementationName());
		} else if (StatusChange.Action.DISMISS == delegate.getAction()) {
			Context.getService(CaseReportService.class).dismissCaseReport(getParent(delegate));
		} else {
			throw new GenericRestException("Invalid action value");
		}
		return null;
	}
	
	/**
	 * @see DelegatingSubResource#getParent(Object)
	 */
	@Override
	public CaseReport getParent(StatusChange instance) {
		return instance.getCaseReport();
	}
	
	/**
	 * @see DelegatingSubResource#setParent(Object, Object)
	 */
	@Override
	public void setParent(StatusChange instance, CaseReport parent) {
		instance.setCaseReport(parent);
	}
	
	/**
	 * @see DelegatingSubResource#doGetAll(Object, RequestContext)
	 */
	@Override
	public PageableResult doGetAll(CaseReport parent, RequestContext context) throws ResponseException {
		throw new UnsupportedOperationException();
	}
	
	/**
	 * @see DelegatingSubResource#getByUniqueId(String)
	 */
	@Override
	public StatusChange getByUniqueId(String uniqueId) {
		throw new UnsupportedOperationException();
	}
	
	/**
	 * @see DelegatingSubResource#delete(Object, String, RequestContext)
	 */
	@Override
	protected void delete(StatusChange delegate, String reason, RequestContext context) throws ResponseException {
		throw new UnsupportedOperationException();
	}
	
	/**
	 * @see DelegatingSubResource#newDelegate()
	 */
	@Override
	public StatusChange newDelegate() {
		return new StatusChange();
	}
	
	/**
	 * @see DelegatingSubResource#purge(Object, RequestContext)
	 */
	@Override
	public void purge(StatusChange delegate, RequestContext context) throws ResponseException {
		throw new UnsupportedOperationException();
	}
}
