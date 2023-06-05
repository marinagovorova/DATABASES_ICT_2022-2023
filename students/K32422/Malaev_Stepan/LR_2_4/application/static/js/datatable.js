// noinspection JSUnresolvedFunction

$(document).ready(function () {
    let originalData = {};

    async function postData(url = '', data = {}) {
        try {
            return await fetch(url, {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            });
        } catch (error) {
            console.error("There was an error with fetch: ", error);
        }
    }


    function getTableName() {
        return $('#table-section').data('table-name');
    }

    async function handleErrorResponse(response) {
        const responseData = await response.json();
        alert(responseData.message);
    }

    function handleSuccessResponse() {
        window.location.reload();
    }

    $('#data-table').DataTable();

    $('#spinner').addClass('d-none')
    $('#datatable-content').removeClass('d-none');

    $('#addForm').on('submit', async function (e) {
        e.preventDefault();

        const data = {
            "table_name": getTableName(),
            "table_data": Object.fromEntries(new FormData(this).entries())
        };

        const response = await postData("/tables/operation/add", data);

        response.ok ? handleSuccessResponse() : await handleErrorResponse(response);
    });

    $(document).on('click', '.updateBtn', async function () {
        const data = {
            "table_name": getTableName(),
            "entry_id": $(this).data('entry-id')
        };

        const response = await postData("/tables/operation/get", data);

        if (response.ok) {
            originalData = await response.json();
            Object.entries(originalData).forEach(([col, value]) => {
                $(`#updateFloatingInput${col}`).val(value);
            });
            $('#update').modal('show');
        } else {
            await handleErrorResponse(response);
        }
    });

    $('#updateForm').on('submit', async function (e) {
        e.preventDefault();

        const formData = new FormData(this);
        let tableData = Object.fromEntries(formData.entries())
        tableData = Object.keys(tableData)
            .reduce((obj, key) => {
                if (tableData[key] !== originalData[key]) obj[key] = tableData[key];
                return obj;
            }, {});

        if (Object.keys(tableData).length <= 1) {
            alert('Недостаточно данных для обновления. Пожалуйста, внесите изменения как минимумум в одно поле.');
            return;
        }

        const data = {
            "table_name": getTableName(),
            "table_data": tableData
        };

        const response = await postData("/tables/operation/update", data);

        response.ok ? handleSuccessResponse() : await handleErrorResponse(response);
    });

    $(document).on('click', '.deleteBtn', async function (e) {
        e.preventDefault();

        if (confirm('Are you sure you want to delete this data?')) {
            const data = {
                "table_name": getTableName(),
                "entry_id": $(this).data('entry-id')
            };

            const response = await postData("/tables/operation/delete", data);

            response.ok ? handleSuccessResponse() : await handleErrorResponse(response);
        }
    });
});
